Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264791AbUGZB20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264791AbUGZB20 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 21:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264795AbUGZB20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 21:28:26 -0400
Received: from ms-smtp-02-smtplb.ohiordc.rr.com ([65.24.5.136]:43148 "EHLO
	ms-smtp-02-eri0.ohiordc.rr.com") by vger.kernel.org with ESMTP
	id S264791AbUGZB2Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 21:28:25 -0400
From: Rob Couto <rpc@cafe4111.org>
Reply-To: rpc@cafe4111.org
Organization: Cafe 41:11
To: linux-kernel@vger.kernel.org
Subject: Re: 3C905 and ethtool
Date: Sun, 25 Jul 2004 21:27:37 -0400
User-Agent: KMail/1.6.2
References: <200407251016.22001.cijoml@volny.cz> <200407252009.03770.rpc@cafe4111.org> <200407260218.29966.cijoml@volny.cz>
In-Reply-To: <200407260218.29966.cijoml@volny.cz>
Cc: cijoml@volny.cz
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200407252127.37159.rpc@cafe4111.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is weird. I'm able to try 4 machines: one has a RTL8139 card (8139too), 
two others are 1) Kingston and 2) generic cards (tulip), and the server uses 
2x 3Com (3c59x) cards. and ethtool returns nothing, no data from any of them. 
What am I missing?

"Curiouser and curiouser!"

-- 
Rob Couto [rpc@cafe4111.org]
computer safety tip: use only a non-conducting, static-free hammer.
    -unless Internet Explorer is involved.
--
