Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264428AbTLQPUL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 10:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264429AbTLQPUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 10:20:11 -0500
Received: from main.gmane.org ([80.91.224.249]:49900 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264428AbTLQPUJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 10:20:09 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: no atapi cdrecord burning with 2.6.0-test11-bk10 / bk13
Date: Wed, 17 Dec 2003 16:20:05 +0100
Message-ID: <yw1xd6anjwt6.fsf@kth.se>
References: <Pine.LNX.4.21.0312171604390.32339-100000@needs-no.brain.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:Y4uL5/wYs995c3hgsNudQ49wZZU=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Voegtle <thomas@voegtle-clan.de> writes:

> cdrecord -dev=ATAPI -scanbus  with 2.6.0-test11-bk10 and bk13 shows this:

cdrecord dev=/dev/cdrom -scanbus  is the recommended way, whatever
cdrecord tries to make you believe.

-- 
Måns Rullgård
mru@kth.se

