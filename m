Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131210AbQLJRmU>; Sun, 10 Dec 2000 12:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131365AbQLJRmK>; Sun, 10 Dec 2000 12:42:10 -0500
Received: from barnowl.demon.co.uk ([158.152.23.247]:1299 "EHLO
	barnowl.demon.co.uk") by vger.kernel.org with ESMTP
	id <S131210AbQLJRl7>; Sun, 10 Dec 2000 12:41:59 -0500
Mail-Copies-To: never
To: linux-kernel@vger.kernel.org
Subject: Re: Enviromental Monitoring
In-Reply-To: <002901c062c9$f183d030$fdfea8c0@localnet>
	<20001210110213.X6567@cadcamlab.org>
From: Graham Murray <graham@barnowl.demon.co.uk>
Date: 10 Dec 2000 17:11:23 +0000
In-Reply-To: <20001210110213.X6567@cadcamlab.org>
Message-ID: <m2aea42ock.fsf@barnowl.demon.co.uk>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Samuelson <peter@cadcamlab.org> writes:

> [Andrew Stubbs]
> > Has anyone implemented a /proc device or user program to interrogate
> > the enviromental attirbutes (temp, voltage etc) that many
> > motherboards provide via their bios's ?
> 
> Do a search on 'lm_sensors'.

Does this work with the latest 2.4.0-testxx kernels. It stopped
working for me quite a few kernel tests ago.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
