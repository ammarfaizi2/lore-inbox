Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283269AbRL1Q7i>; Fri, 28 Dec 2001 11:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283438AbRL1Q7T>; Fri, 28 Dec 2001 11:59:19 -0500
Received: from mailf.telia.com ([194.22.194.25]:24801 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id <S283269AbRL1Q7K>;
	Fri, 28 Dec 2001 11:59:10 -0500
Date: Fri, 28 Dec 2001 18:03:49 +0100
From: =?iso-8859-1?Q?Andr=E9?= Dahlqvist <andre.dahlqvist@telia.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Sound fails to build when non-modular with new binutils
Message-ID: <20011228170349.GA4955@telia.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011228151608.GA1870@telia.com> <4841.1009556591@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4841.1009556591@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@ocs.com.au> wrote:

> Run this, it will say precisely where the problem lies:

Thanks Keith. Below is the output:

Finding objects, 315 objects, ignoring 0 module(s)
Finding conglomerates, ignoring 29 conglomerate(s)
Scanning objects
Error: ./drivers/sound/via82cxxx_audio.o .data refers to 00000034
R_386_32          .text.exit
Done
-- 

André Dahlqvist <andre.dahlqvist@telia.com>

