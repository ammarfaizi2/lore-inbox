Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268713AbUJKHM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268713AbUJKHM1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 03:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268714AbUJKHM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 03:12:27 -0400
Received: from imag.imag.fr ([129.88.30.1]:51659 "EHLO imag.imag.fr")
	by vger.kernel.org with ESMTP id S268713AbUJKHM0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 03:12:26 -0400
Date: Mon, 11 Oct 2004 09:12:21 +0200
To: linux-kernel@vger.kernel.org
Subject: Re: possible GPL violation by Free
Message-ID: <20041011071221.GA2034@linux.ensimag.fr>
Reply-To: 1097456379.27877.51.camel@frenchenigma
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
From: Matthieu Castet <mat@ensilinx1.imag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (imag.imag.fr [129.88.30.1]); Mon, 11 Oct 2004 09:12:23 +0200 (CEST)
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-Information: Please contact the ISP for more information
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, 2004-10-10 at 12:28 +0200, Willy Tarreau wrote:
> > (at least provide the
> > result of an nmap -O). For most end-users, "linux" is the word for "a
> > reliable embedded OS with IP support".
> 
> Here it is, on a Freebox v1 (the Freebox distributed now is version 3,
> but version 1 was still distributed less than one year ago (i.e. under
> the 3 years limit in the GPL)).
> Disclaimer: this scan output should be taken carefully. Please do not
> jump to conclusions.
> (IP and MAC hidden)

Are you sure you don't scan your computer : the freebox v1 don't have
router mode and act like a bridge.
It seem suspicious that all the port are closed instead of filtered.

On the freebox v3 it is difficult to use nmap for guessing the os : in
router mode all the port are filtered except those you forward to your
computer.

Matthieu
