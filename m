Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315480AbSGIPiC>; Tue, 9 Jul 2002 11:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315481AbSGIPiC>; Tue, 9 Jul 2002 11:38:02 -0400
Received: from mnh-1-21.mv.com ([207.22.10.53]:55812 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S315480AbSGIPh7>;
	Tue, 9 Jul 2002 11:37:59 -0400
Message-Id: <200207091642.LAA02424@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-user@lists.sourceforge.net
Subject: Re: [uml-user] Re: user-mode port 0.58-2.4.18-36 
In-Reply-To: Your message of "Tue, 09 Jul 2002 05:16:18 +0200."
             <20020709031618.GC113@elf.ucw.cz> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 09 Jul 2002 11:42:37 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pavel@ucw.cz said:
> ...and using CAP_SYS_RAWIO... 

Do you really think I'm that stupid?

CAP_SYS_RAWIO is removed from the bounding set.

				Jeff

