Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265325AbTFRPqm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 11:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265323AbTFRPqi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 11:46:38 -0400
Received: from nx5.HRZ.Uni-Dortmund.DE ([129.217.131.21]:23589 "EHLO
	nx5.hrz.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S265304AbTFRPqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 11:46:06 -0400
Date: Wed, 18 Jun 2003 17:55:34 +0200 (CEST)
From: Ingo Buescher <usenet-2003@r-arcology.de>
X-X-Sender: gallatin@nathan.cybernetics.com
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Cursor in 2.4.21
In-Reply-To: <20030618144919.2493.qmail@mail.ec-red.com>
Message-ID: <Pine.LNX.4.56.0306181754330.11809@anguna.ploreargvpf.pbz>
References: <20030618144919.2493.qmail@mail.ec-red.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jun 2003, Sergio Aguayo wrote:

> Date: Wed, 18 Jun 2003 09:49:19 -0500
> From: Sergio Aguayo <sergioag@ec-red.com>
> To: linux-kernel@vger.kernel.org
> Subject: PROBLEM: Cursor in 2.4.21
>
> Greetings,
>
> I've found a little bug with the cursor under kernel 2.4.21. I'm using the
> NVIDIA TNT2 frambuffer and the cursor appears ok, but there are to "cursors"
> on the first pixels of the screen (up). These bug wasn't present in 2.4.20.
>

Same here. The very first line appears to be blue (also using rivafb on a
nvidia tnt2 card).

> Sergio Aguayo

IB
-- 
"The only purpose for which power can be rightfully exercised over any
member of a civilized community, against his will, is to prevent harm
to others. His own good, either physical or moral, is not a sufficient
warrant" -- John Stuart Mill, "On Liberty", 1859
