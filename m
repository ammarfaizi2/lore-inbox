Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132678AbRASA23>; Thu, 18 Jan 2001 19:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130509AbRASA2T>; Thu, 18 Jan 2001 19:28:19 -0500
Received: from cp912944-a.mtgmry1.md.home.com ([24.18.149.178]:60550 "EHLO
	zalem.puupuu.org") by vger.kernel.org with ESMTP id <S135955AbRASA2E>;
	Thu, 18 Jan 2001 19:28:04 -0500
Date: Thu, 18 Jan 2001 19:27:58 -0500
From: Olivier Galibert <galibert@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
Message-ID: <20010118192758.A2656@zalem.puupuu.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010118212441.E28276@athlon.random> <200101182037.XAA08671@ms2.inr.ac.ru> <20010118220428.G28276@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010118220428.G28276@athlon.random>; from andrea@suse.de on Thu, Jan 18, 2001 at 10:04:28PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2001 at 10:04:28PM +0100, Andrea Arcangeli wrote:
> NAGLE algorithm is only one, CORK algorithm is another different algorithm. So
> probably it would be not appropriate to mix CORK and NAGLE under the name
> "CONTROL_NAGLING", but certainly I agree they could stay together under another
> name ;).

TCP_FLOW_CONTROL ?

  OG.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
