Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264257AbTKTCoc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 21:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbTKTCoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 21:44:30 -0500
Received: from ns.media-solutions.ie ([212.67.195.98]:5395 "EHLO
	mx.media-solutions.ie") by vger.kernel.org with ESMTP
	id S264257AbTKTCo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 21:44:27 -0500
Message-ID: <3FBC2A1E.3010901@media-solutions.ie>
Date: Wed, 19 Nov 2003 20:42:38 -0600
From: Keith Whyte <keith@media-solutions.ie>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: es-mx, es-es, en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-gcc@vger.kernel.org,
       linux-admin@vger.kernel.org
Subject: solution: 2.4.18 fork & defunct child.
References: <1069053524.3fb87654286b5@ssl.buz.org> <3FB8E40F.EF61CA7@gmx.de>
In-Reply-To: <3FB8E40F.EF61CA7@gmx.de>
X-Enigmail-Version: 0.76.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-RelayImmunity: 212.67.195.98
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks thanks to everyone who helped me out with this, I just found the 
file 982235016-gtkrc-429249277 in /tmp
It kept reappearing as it tried to rm * -r in /tmp and
a quick google search led me to find out where it came from.

A few weeks ago i installed a binary that i got from a friends machine, 
and i just checked his machine. It has the trojan also. that explains a 
lot. It was a realserver binary (no longer available for d/l)and i ran 
it once as root as it likes to listen on port 554, before I changed that 
config and set up a user to run it. aggh. so easy to let something slip 
through. never trust binaries... no matter where they come from.

Keith.


