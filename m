Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261292AbVBGWiQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbVBGWiQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 17:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbVBGWiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 17:38:16 -0500
Received: from mx2.elte.hu ([157.181.151.9]:63905 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261292AbVBGWgW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 17:36:22 -0500
Date: Mon, 7 Feb 2005 23:36:09 +0100
From: Ingo Molnar <mingo@elte.hu>
To: pageexec@freemail.hu
Cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@redhat.com>,
       "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: Sabotaged PaXtest (was: Re: Patch 4/6  randomize the stack pointer)
Message-ID: <20050207223609.GA12609@elte.hu>
References: <4202BFDB.24670.67046BC@localhost> <42080689.15768.1B0C5E5F@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42080689.15768.1B0C5E5F@localhost>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


btw., do you consider PaX as a 100% sure solution against 'code
injection' attacks (meaning that the attacker wants to execute an
arbitrary piece of code, and assuming the attacked application has a
stack overflow)? I.e. does PaX avoid all such attacks in a guaranteed
way?

	Ingo
