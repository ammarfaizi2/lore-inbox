Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280666AbRKYPEP>; Sun, 25 Nov 2001 10:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280700AbRKYPEG>; Sun, 25 Nov 2001 10:04:06 -0500
Received: from mercury.rus.uni-stuttgart.de ([129.69.1.226]:27528 "EHLO
	mercury.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S277152AbRKYPEA>; Sun, 25 Nov 2001 10:04:00 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Severe Linux 2.4 kernel memory leakage
In-Reply-To: <1006699767.1178.0.camel@gandalf.chabotc.com>
From: Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>
Date: 25 Nov 2001 16:03:55 +0100
In-Reply-To: <1006699767.1178.0.camel@gandalf.chabotc.com> (Chris Chabot's message of "25 Nov 2001 15:49:27 +0100")
Message-ID: <tgy9kuevtw.fsf@mercury.rus.uni-stuttgart.de>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Chabot <chabotc@reviewboard.com> writes:

> When the box keeps on running for about a month,

Which kernels have you run for about a month, and which ones showed
this extreme behavior?  Obviously not 2.4.15...

The amount of available memory decreasing is quite normal, due to the
growing cache.

-- 
Florian Weimer 	                  Florian.Weimer@RUS.Uni-Stuttgart.DE
University of Stuttgart           http://cert.uni-stuttgart.de/
RUS-CERT                          +49-711-685-5973/fax +49-711-685-5898
