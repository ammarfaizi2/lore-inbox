Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135456AbRDMJsM>; Fri, 13 Apr 2001 05:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135457AbRDMJr5>; Fri, 13 Apr 2001 05:47:57 -0400
Received: from csl.Stanford.EDU ([171.64.66.149]:20988 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S135456AbRDMJrt>;
	Fri, 13 Apr 2001 05:47:49 -0400
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200104130947.CAA21780@csl.Stanford.EDU>
Subject: [CHECKER] security rules?
To: linux-kernel@vger.kernel.org
Date: Fri, 13 Apr 2001 02:47:46 -0700 (PDT)
Cc: mc@cs.Stanford.EDU
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We're looking at making a set of security checkers.  Does anyone have
suggestions for good things to go after in addition to the usual
copy_*_user and buffer overrun bugs?  For example, are there any
documents that describe the rules for when/how 'capable' is supposed to
be used?

Thanks for any help,
Dawson
