Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbTDQT4X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 15:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262219AbTDQT4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 15:56:22 -0400
Received: from AMontpellier-104-1-6-14.abo.wanadoo.fr ([81.51.196.14]:55028
	"EHLO tethys.solarsys.org") by vger.kernel.org with ESMTP
	id S262005AbTDQT4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 15:56:22 -0400
Date: Thu, 17 Apr 2003 22:08:14 +0200
From: wwp <subscript@free.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: Small fix for VMWare 3.2 (3.x?) on Redhat 9 (any 2.4.20+
 kernel?)
Message-Id: <20030417220814.6cc48123.subscript@free.fr>
In-Reply-To: <E193vrp-0006P4-00@trillium-hollow.org>
References: <E193vrp-0006P4-00@trillium-hollow.org>
X-Mailer: Sylpheed version 0.8.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi erich@uruk.org,


On Fri, 11 Apr 2003 03:34:45 -0700 erich@uruk.org wrote:

> FYI...
> 
> I'm running Redhat 9, and to get my copy of VMWare 3.2 working with it,
> I had to make a one-line fix to a source file inside the "vmnet.tar" file
> for building the vmnet module.

I did nearly the same for VMWare 3.2 to be used with SuSE 8.1. Some changes in
the Makefiles and other files to fix compilation issues (mostly gcc 3.2).
If someone is interested I can send the .tar file.


Regards,

-- 
wwp
