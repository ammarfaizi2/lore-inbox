Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317214AbSGNXZi>; Sun, 14 Jul 2002 19:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317215AbSGNXZi>; Sun, 14 Jul 2002 19:25:38 -0400
Received: from ns.suse.de ([213.95.15.193]:64527 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317214AbSGNXZh>;
	Sun, 14 Jul 2002 19:25:37 -0400
Date: Mon, 15 Jul 2002 01:28:23 +0200
From: Dave Jones <davej@suse.de>
To: Ben Clifford <benc@hawaga.org.uk>
Cc: Heinz Diehl <hd@cavy.de>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.25-dj2
Message-ID: <20020715012823.I20781@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Ben Clifford <benc@hawaga.org.uk>, Heinz Diehl <hd@cavy.de>,
	linux-kernel@vger.kernel.org
References: <20020714115525.C28859@suse.de> <Pine.LNX.4.44.0207141445390.2823-100000@barbarella.hawaga.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207141445390.2823-100000@barbarella.hawaga.org.uk>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 14, 2002 at 02:49:31PM -0700, Ben Clifford wrote:
 > My ide-cd module was loaded automatically at boot.
 > I loaded the ide-scsi24 module (which didn't detect anything because the 
 > ide-cd module already had both the CD-ROM and CD-RW drives).
 > So I rmmoded ide-cd and ide-scsi24.
 > Then I modprobed ide-scsi and got two oopses in quick succession which 
 > locked up the machine :-(
 > 
 > Anyone else have any luck with ide-scsi24?

decode oops, post, cc: axboe@suse.de and andre@linux-ide.org

    Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
