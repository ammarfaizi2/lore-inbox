Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271369AbRHOTOq>; Wed, 15 Aug 2001 15:14:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271370AbRHOTOg>; Wed, 15 Aug 2001 15:14:36 -0400
Received: from ns.suse.de ([213.95.15.193]:3078 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S271367AbRHOTOS>;
	Wed, 15 Aug 2001 15:14:18 -0400
Date: Wed, 15 Aug 2001 21:14:29 +0200
From: Hubert Mantel <mantel@suse.de>
To: "Heinz J . Mauelshagen" <mauelshagen@sistina.com>
Cc: Kurt Garloff <garloff@suse.de>, linux-lvm@sistina.com,
        lvm-devel@sistina.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, sistina@sistina.com, mge@sistina.com
Subject: Re: *** ANNOUNCEMENT *** LVM 1.0 available at www.sistina.com
Message-ID: <20010815211429.A28868@suse.de>
In-Reply-To: <20010815175659.A29749@sistina.com> <20010815182548.U3941@gum01m.etpnet.phys.tue.nl> <20010815185005.A32239@sistina.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <20010815185005.A32239@sistina.com>; from mauelshagen@sistina.com on Wed, Aug 15, 2001 at 06:50:05PM +0200
Organization: SuSE Labs, Nuernberg, Germany
X-Operating-System: SuSE Linux - Kernel 2.4.7-4GB
X-PGP-Key: 1024D/B0DFF780, 1024R/CB848DFD
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 15, Heinz Mauelshagen wrote:

> Well, as explained before on the lists we had an algorithm calculating
> the offset to the first PE in place till 0.9.1 Beta 7.
> 
> Therefore, we *need* to run the installed version < LVM 0.9.1 Beta 8 to
> retrieve that sector offset for all PVs and change the metadata to hold the
> offset. No known way around this.
          ^^^^^^^^^^^^^^^^^^^^^^^^

You are kidding, aren't you?

> Heinz    -- The LVM Guy --
                                                                  -o)
    Hubert Mantel              Goodbye, dots...                   /\\
                                                                 _\_v
