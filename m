Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292538AbSBZR4l>; Tue, 26 Feb 2002 12:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292485AbSBZR40>; Tue, 26 Feb 2002 12:56:26 -0500
Received: from mailg.telia.com ([194.22.194.26]:4070 "EHLO mailg.telia.com")
	by vger.kernel.org with ESMTP id <S292478AbSBZRzW>;
	Tue, 26 Feb 2002 12:55:22 -0500
Date: Tue, 26 Feb 2002 18:58:51 +0100
From: =?iso-8859-1?Q?Andr=E9?= Dahlqvist <andre.dahlqvist@telia.com>
To: Simon Turvey <turveysp@ntlworld.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IDE error on 2.4.17
Message-ID: <20020226175851.GA3223@telia.com>
In-Reply-To: <000901c1beec$6ac68940$030ba8c0@mistral>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <000901c1beec$6ac68940$030ba8c0@mistral>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2002 at 05:38:35PM -0000, Simon Turvey wrote:

> hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
> hda: dma_intr: error=0x40 { UncorrectableError }, LBAsect=250746,
                              ^^^^^^^^^^^^^^^^^^
If I'm not misstaking that's hardware error.
-- 

André Dahlqvist <andre.dahlqvist@telia.com>
