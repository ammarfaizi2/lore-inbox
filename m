Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbTKEPRm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 10:17:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262941AbTKEPRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 10:17:42 -0500
Received: from cpc2-blfs2-6-0-cust217.blfs.cable.ntl.com ([81.99.21.217]:2725
	"EHLO foobox") by vger.kernel.org with ESMTP id S262687AbTKEPRl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 10:17:41 -0500
Message-ID: <3FA91493.7060009@ntlworld.com>
Date: Wed, 05 Nov 2003 15:17:39 +0000
From: Matt <dirtbird@ntlworld.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031024 Debian/1.4-6 StumbleUpon/1.87
X-Accept-Language: en, en-gb, ja
MIME-Version: 1.0
To: herbert@gondor.apana.org.au
Cc: linux-kernel@vger.kernel.org
Subject: Re:[MOUSE] Alias for /dev/psaux
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

had excatly the same problem moving to test9-mm1, way i fixed it was to 
pass the options "psmouse_rate=60 psmouse_resolution=200" to the kernel 
at boot (these were the old defaults).

    matt


