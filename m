Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279399AbRKGBao>; Tue, 6 Nov 2001 20:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280644AbRKGBad>; Tue, 6 Nov 2001 20:30:33 -0500
Received: from dorf.wh.uni-dortmund.de ([129.217.255.136]:63503 "HELO
	mail.dorf.wh.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S279399AbRKGBaM>; Tue, 6 Nov 2001 20:30:12 -0500
Date: Wed, 7 Nov 2001 02:30:06 +0100
From: Patrick Mau <mau@oscar.prima.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Recent thread abount the /proc files layout
Message-ID: <20011107023006.A4860@oscar.dorf.de>
Reply-To: Patrick Mau <mau@oscar.prima.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I know I will regret to throw my 2 cents to that discussion,
but I think that the discussion started because of the high
number of syscalls processing /proc information.

I would still like to see a binary interface to /proc data
regardless of the existance/redesign of human/shell/perl
parseable data.

feel free to ignore this post, but I really would like
to have a small library to do all that in binary form.

cheers,
Patrick
