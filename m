Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273894AbRJDMu1>; Thu, 4 Oct 2001 08:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273896AbRJDMuS>; Thu, 4 Oct 2001 08:50:18 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:49422 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S273894AbRJDMuM>;
	Thu, 4 Oct 2001 08:50:12 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH - gameport_{,un}register_port must be static when inline 
In-Reply-To: Your message of "Thu, 04 Oct 2001 15:32:54 +1000."
             <15291.62598.349815.333342@notabene.cse.unsw.edu.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 04 Oct 2001 22:50:28 +1000
Message-ID: <30948.1002199828@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Oct 2001 15:32:54 +1000 (EST), 
Neil Brown <neilb@cse.unsw.edu.au> wrote:
># CONFIG_INPUT_GAMEPORT is not set
>CONFIG_SOUND=y
>CONFIG_SOUND_ESSSOLO1=y
>CONFIG_SOUND_ES1370=y

My apologies, the symptoms sounded like a bug I fixed in 2.4.5-ac but
are actually different.  Your original patch was correct.

