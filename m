Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310271AbSCLBCl>; Mon, 11 Mar 2002 20:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310264AbSCLBCg>; Mon, 11 Mar 2002 20:02:36 -0500
Received: from [194.46.8.33] ([194.46.8.33]:47373 "EHLO angusbay.vnl.com")
	by vger.kernel.org with ESMTP id <S310271AbSCLBCV>;
	Mon, 11 Mar 2002 20:02:21 -0500
Date: Tue, 12 Mar 2002 01:13:58 +0000
From: Dale Amon <amon@vnl.com>
To: Dale Amon <amon@vnl.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        George Bonser <george@gator.com>, Mark Hahn <hahn@physics.mcmaster.ca>,
        linux-kernel@vger.kernel.org
Subject: Re: Pentium mobo fails on upgrade from 2.2 to 2.4
Message-ID: <20020312011358.GB23544@vnl.com>
Mail-Followup-To: Dale Amon <amon@vnl.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	George Bonser <george@gator.com>,
	Mark Hahn <hahn@physics.mcmaster.ca>, linux-kernel@vger.kernel.org
In-Reply-To: <20020309134540.GZ13355@vnl.com> <E16jm3j-0002Ew-00@the-village.bc.nu> <20020311120631.GO3296@vnl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020311120631.GO3296@vnl.com>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux, the choice of a GNU generation
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2002 at 12:06:31PM +0000, Dale Amon wrote:
> It appears that it was turned on in my 2.2.18 kernel

Hmmm, seems I left something out. The "it" was

	CONFIG_IDEDMA_AUTO

