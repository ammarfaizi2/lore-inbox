Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422639AbWBNQjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422639AbWBNQjy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 11:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422638AbWBNQjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 11:39:54 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:10202 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP
	id S1422636AbWBNQjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 11:39:53 -0500
Date: Tue, 14 Feb 2006 17:40:03 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: Christian <christiand59@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc: CIFS reproducibly freezes the computer
Message-ID: <20060214164002.GC5905@stiffy.osknowledge.org>
References: <20060214135016.GC10701@stusta.de> <200602141659.40176.christiand59@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602141659.40176.christiand59@web.de>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.16-rc3-marc-g108dff7d-dirty
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is that maybe dependant on _what_ version of Samba is running on the receiving
end?

BTW, my fstab entry is like this:

//192.168.100.2/X_Server_Export /mnt/cifs_ggh_export cifs user,username=mkoschewski,password=********,uid=1000,gid=1000,dir_mode=777,file_mode=666,rw 0 0


