Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129393AbRCEQhT>; Mon, 5 Mar 2001 11:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129417AbRCEQg7>; Mon, 5 Mar 2001 11:36:59 -0500
Received: from danielle.hinet.hr ([195.29.254.157]:40976 "EHLO
	danielle.hinet.hr") by vger.kernel.org with ESMTP
	id <S129393AbRCEQgu>; Mon, 5 Mar 2001 11:36:50 -0500
Date: Mon, 5 Mar 2001 17:37:21 +0100
From: Mario Mikocevic <mozgy@hinet.hr>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.3-pre2: Can't build md.o as module: unresolved symbol
Message-ID: <20010305173721.A14760@danielle.hinet.hr>
In-Reply-To: <ysdn1b0lbtl.fsf@tuborg.ibr.cs.tu-bs.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <ysdn1b0lbtl.fsf@tuborg.ibr.cs.tu-bs.de>; from thuerman@ibr.cs.tu-bs.de on Mon, Mar 05, 2001 at 12:00:54PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've got a bit more ->

depmod: *** Unresolved symbols in /lib/modules/2.4.3-pre2/kernel/drivers/i2o/i2o_scsi.o
depmod:         i2o_install_handler
depmod:         i2o_remove_handler
depmod:         i2o_find_controller
depmod:         i2o_query_scalar
depmod:         i2o_num_controllers
depmod: *** Unresolved symbols in /lib/modules/2.4.3-pre2/kernel/drivers/md/md.o
depmod:         md_autodetect_dev

-- 
Mario Mikoèeviæ (Mozgy)
My favourite FUBAR ...
