Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269393AbRHGUH7>; Tue, 7 Aug 2001 16:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269404AbRHGUHu>; Tue, 7 Aug 2001 16:07:50 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:37136 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269393AbRHGUHi>; Tue, 7 Aug 2001 16:07:38 -0400
Subject: Re: Linux on FIVA MPC-206E, APM and other issues
To: joseph@5sigma.com (Joseph N. Hall)
Date: Tue, 7 Aug 2001 21:09:21 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010807193417Z269364-28344+2551@vger.kernel.org> from "Joseph N. Hall" at Aug 07, 2001 12:34:00 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15UDAH-0003u1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> * sleep/hibernate either hangs the machine (must hit h/w reset switch
> afaik) or does nothing useful (nothing at all, or seemingly tries to 
> sleep and immediately revives)

The older fiva's used to need a kernel patch because they forgot to turn
the disk back on properly on a resume, you might want to search for fiva
patches

