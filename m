Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281246AbRKERLN>; Mon, 5 Nov 2001 12:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281247AbRKERKw>; Mon, 5 Nov 2001 12:10:52 -0500
Received: from nycsmtp2fb.rdc-nyc.rr.com ([24.29.99.78]:26375 "EHLO nyc.rr.com")
	by vger.kernel.org with ESMTP id <S281246AbRKERKn>;
	Mon, 5 Nov 2001 12:10:43 -0500
Message-ID: <3BE6C571.3EBD39EC@nyc.rr.com>
Date: Mon, 05 Nov 2001 11:59:29 -0500
From: John Weber <weber@nyc.rr.com>
Organization: WorldWideWeber
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: binfmt_misc and /proc
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running 2.4.13.  What is the rationale for forcing users to mount
/proc/sys/fs/binfmt_misc separately?  I personally find the idea of 
mounting "none" to some subspace of /proc a little disturbing -- I don't
like breaking metaphors :).
