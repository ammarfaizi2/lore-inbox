Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272079AbRIEX1f>; Wed, 5 Sep 2001 19:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272163AbRIEX1Z>; Wed, 5 Sep 2001 19:27:25 -0400
Received: from PSI.MIT.EDU ([18.77.0.154]:57731 "EHLO psi.mit.edu")
	by vger.kernel.org with ESMTP id <S272079AbRIEX1M>;
	Wed, 5 Sep 2001 19:27:12 -0400
Date: Wed, 5 Sep 2001 19:29:02 -0400 (EDT)
From: Taylan Akdogan <akdogan@mit.edu>
To: <linux-kernel@vger.kernel.org>
Subject: ptrace and clone
In-Reply-To: <Pine.LNX.4.21.0008281517070.6239-100000@psi.mit.edu>
Message-ID: <Pine.LNX.4.33.0109051924370.23879-100000@psi.mit.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

   I was wondering; I can't trace a cloned child using ptrace
call (and strace program) I found a couple of mails regarding the
same problem within the mail archive, but I couldn't find any
solution for it. Am I doing something wrong, or there really
isn't a solution yet? (I'm using v2.4.9)

Regards,
Taylan

---=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=---
Taylan Akdogan              Massachusetts Institute of Technology
akdogan@mit.edu                             Department of Physics
---=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=---

