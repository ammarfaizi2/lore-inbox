Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263272AbREaXCI>; Thu, 31 May 2001 19:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263269AbREaXB6>; Thu, 31 May 2001 19:01:58 -0400
Received: from csl.Stanford.EDU ([171.64.66.149]:49133 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S263272AbREaXBt>;
	Thu, 31 May 2001 19:01:49 -0400
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200105312301.QAA16524@csl.Stanford.EDU>
Subject: [QUESTION] which routines must be re-entrant?
To: linux-kernel@vger.kernel.org
Date: Thu, 31 May 2001 16:01:34 -0700 (PDT)
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there an easy way to tell which routines must be re-entrant? 
(it doesn't have to be exhaustive, even an incomplete set is useful)

I was going to write a checker to make sure supposedly re-entrant
routines actually were, but was having a hard time figuring out which
ones were supposed to be...

Thanks,
Dawson
