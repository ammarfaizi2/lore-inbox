Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261377AbVG0S17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbVG0S17 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 14:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262300AbVG0SZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 14:25:17 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:31917 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S262383AbVG0SY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 14:24:59 -0400
Message-Id: <1122488682.7051.239374398@webmail.messagingengine.com>
X-Sasl-Enc: lPYm6tIdpDyACShvY3gWAj358QHaa5mFBAz9mnkilwsI 1122488682
From: "Clayton Weaver" <cgweav@fastmail.fm>
To: linux-kernel@vger.kernel.org
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="ISO-8859-1"
MIME-Version: 1.0
X-Mailer: MIME::Lite 1.5  (F2.73; T1.001; A1.64; B3.05; Q3.03)
Subject: Re: xor as a lazy comparison
Date: Wed, 27 Jul 2005 11:24:42 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is not xor (^) typically compiled to a
one cycle instruction regardless of
requested optimization level? (May not
always have been the case on every
target architecture for != equality
tests.)
Clayton Weaver
cgweav at fastmail dot fm

PS:
Anyone know where I can get
a waterproof, battery powered gps that will fit inside the handle of a Fenwick?

