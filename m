Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315256AbSDWQNN>; Tue, 23 Apr 2002 12:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315257AbSDWQNM>; Tue, 23 Apr 2002 12:13:12 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:47608 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S315256AbSDWQNL>; Tue, 23 Apr 2002 12:13:11 -0400
Date: Tue, 23 Apr 2002 09:12:00 -0700
From: Chris Wright <chris@wirex.com>
To: Alex Riesen <Alexander.Riesen@synopsys.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [SECURITY] FDs 0, 1, 2 for SUID/SGID programs
Message-ID: <20020423091200.A30228@figure1.int.wirex.com>
Mail-Followup-To: Alex Riesen <Alexander.Riesen@synopsys.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <87662jiz3b.fsf@CERT.Uni-Stuttgart.DE> <20020422121819.A13864@figure1.int.wirex.com> <20020423140239.C1142@riesen-pc.gr05.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alex Riesen (Alexander.Riesen@synopsys.com) wrote:
> On Mon, Apr 22, 2002 at 12:18:19PM -0700, Chris Wright wrote:
> > and clone-on-exec file descriptors across execve().  However, there
> 
> that is close-on-exec. Different semantics.

yes, typo. thanks.
-chris
