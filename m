Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267346AbTBNT3v>; Fri, 14 Feb 2003 14:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267367AbTBNT3v>; Fri, 14 Feb 2003 14:29:51 -0500
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:32222 "EHLO
	crisis.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id <S267346AbTBNT3u>; Fri, 14 Feb 2003 14:29:50 -0500
To: Christoph Hellwig <hch@infradead.org>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EISA/sysfs update
References: <1044241767.3924.14.camel@mulgrave>
	<wrp3cmrrwuf.fsf@hina.wild-wind.fr.eu.org>
	<20030214181203.A32737@infradead.org>
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 14 Feb 2003 20:37:41 +0100
Message-ID: <wrpel6atzzu.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <20030214181203.A32737@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Christoph" == Christoph Hellwig <hch@infradead.org> writes:

Christoph> BTW, could you fix eisa_driver_register to properly return
Christoph> 0 on sucess instead of 1?

Huhhh... Nice catch.

Thanks,

        M.
-- 
Places change, faces change. Life is so very strange.
