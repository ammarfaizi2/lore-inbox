Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263993AbTDWKt6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 06:49:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263995AbTDWKt6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 06:49:58 -0400
Received: from siaab1ab.compuserve.com ([149.174.40.2]:24029 "EHLO
	siaab1ab.compuserve.com") by vger.kernel.org with ESMTP
	id S263993AbTDWKt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 06:49:57 -0400
Date: Wed, 23 Apr 2003 06:59:05 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Wanted: A decent assembler
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304230701_MC3-1-359E-3C3@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Output from 'make bzImage' after making some changes:

        Error: non-constant expression in ".if" statement.


  Why is the kernel using a 1-pass assembler?





------
 Chuck
