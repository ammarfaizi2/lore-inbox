Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268133AbUHFNWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268133AbUHFNWp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 09:22:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268135AbUHFNWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 09:22:45 -0400
Received: from ihemail2.lucent.com ([192.11.222.163]:5553 "EHLO
	ihemail2.lucent.com") by vger.kernel.org with ESMTP id S268133AbUHFNWm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 09:22:42 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-ID: <16659.34332.463798.592565@gargle.gargle.HOWL>
Date: Fri, 6 Aug 2004 09:22:36 -0400
From: "John Stoffel" <stoffel@lucent.com>
To: =?ISO-8859-1?Q?=20M=E5ns=5FRullg=E5rd?= <mru@kth.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Firewire hard drives
In-Reply-To: <yw1xu0vhfhkc.fsf@kth.se>
References: <200408051612.36445.caleb_gibbs@sbcglobal.net>
	<16658.38447.591862.21787@gargle.gargle.HOWL>
	<yw1xu0vhfhkc.fsf@kth.se>
X-Mailer: VM 7.14 under Emacs 20.6.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Måns" == Måns Rullgård <mru@kth.se> writes:

Måns> Try giving the sbp2 module the option serialize_io=1.  It helped get
Måns> my firewire case running.

Thanks for the hint.  I'll try that and see how it goes.
Unfortunately, it's at home on USB currently... :] 
