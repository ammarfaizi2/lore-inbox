Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266582AbRGLU7P>; Thu, 12 Jul 2001 16:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266587AbRGLU7E>; Thu, 12 Jul 2001 16:59:04 -0400
Received: from srv01s4.cas.org ([134.243.50.9]:26265 "EHLO srv01.cas.org")
	by vger.kernel.org with ESMTP id <S266582AbRGLU6w>;
	Thu, 12 Jul 2001 16:58:52 -0400
From: Mike Harrold <mharrold@cas.org>
Message-Id: <200107122058.QAA15963@mah21awu.cas.org>
Subject: Re: [PATCH] More pedantry.
To: linux-kernel@alex.org.uk
Date: Thu, 12 Jul 2001 16:58:45 -0400 (EDT)
Cc: dwmw2@infradead.org (David Woodhouse), torvalds@transmeta.com,
        alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <520087372.994974550@[169.254.45.213]> from "Alex Bligh - linux-kernel" at Jul 12, 2001 09:49:10 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> > - *		None of the E1AP-E3AP erratas are visible to the user.
> > + *		None of the E1AP-E3AP errata are visible to the user.
> 
> If you want real pedantry, I think you mean:
> 
> > + *		None of the E1AP-E3AP errata is visible to the user.
> 
> ('none' is singular - read 'not one')
> 
> ... several times within this patch.

No, he was right the first time. Errata is plural. Erratum is the
singular.

/Mike
