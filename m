Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263217AbTDLJnE (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 05:43:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263219AbTDLJnE (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 05:43:04 -0400
Received: from siaab1ab.compuserve.com ([149.174.40.2]:24786 "EHLO
	siaab1ab.compuserve.com") by vger.kernel.org with ESMTP
	id S263217AbTDLJnD (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 12 Apr 2003 05:43:03 -0400
Date: Sat, 12 Apr 2003 05:52:42 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: RE: kernel support for non-English user messages
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304120554_MC3-1-341A-415F@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:


> %s: went up in flames\n\0eth0\0\0


  You could make the placeholder just '%' instead of '%s' if you
were only writing zero-terminated strings.

  Every little bit helps.

--
 "Let's fight till six, and then have dinner," said Tweedledum.
  --Lewis Carroll, _Through the Looking Glass_
