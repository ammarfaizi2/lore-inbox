Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264665AbTAJIvC>; Fri, 10 Jan 2003 03:51:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264666AbTAJIvC>; Fri, 10 Jan 2003 03:51:02 -0500
Received: from buitenpost.surfnet.nl ([192.87.108.12]:21688 "EHLO
	buitenpost.surfnet.nl") by vger.kernel.org with ESMTP
	id <S264665AbTAJIvB>; Fri, 10 Jan 2003 03:51:01 -0500
Date: Fri, 10 Jan 2003 09:59:44 +0100
To: Andrew McGregor <andrew@indranet.co.nz>
Cc: Andres Salomon <dilinger@voxel.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.x inspiron touchpad breakage
Message-ID: <20030110085944.GE15011@surly.surfnet.nl>
References: <pan.2003.01.09.08.27.53.688647@voxel.net> <39260000.1042119837@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39260000.1042119837@localhost.localdomain>
User-Agent: Mutt/1.4i
X-Mailer: Mutt on Debian GNU/Linux sid
X-Editor: vim
X-Organisation: SURFnet bv
X-Address: Radboudburcht, P.O. Box 19035, 3501 DA Utrecht, NL
X-Phone: +31 302 305 305
X-Telefax: +31 302 305 329
From: Niels den Otter <Niels.denOtter@surfnet.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 10 January 2003, Andrew McGregor wrote:
> Works for me on an Inspiron 8000.  The trackpoint does not, which is a
> known bug.  Of course, the 3800 might be different...

My Dell Latitude C400 has both a touchpad and a trackpoint as well.
After a cold boot of 2.5.55 (and previous kernels) only the touchpad
appears to work. To get the trackpoint working I need to hibernate my
laptop and wake it up again. Didn't have this problem with 2.4 kernels.


-- Niels
