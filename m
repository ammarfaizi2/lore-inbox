Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264387AbUDSMbZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 08:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264391AbUDSMbZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 08:31:25 -0400
Received: from web13906.mail.yahoo.com ([216.136.175.69]:39954 "HELO
	web13906.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264387AbUDSMbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 08:31:24 -0400
Message-ID: <20040419123117.97100.qmail@web13906.mail.yahoo.com>
X-RocketYMMF: knobi.rm
Date: Mon, 19 Apr 2004 05:31:17 -0700 (PDT)
From: Martin Knoblauch <knobi@knobisoft.de>
Reply-To: knobi@knobisoft.de
Subject: Re: RESEND: [PATCH] gcc3 does not inline some functions
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis,

 your patch does not apply to 2.4.26. compiler.h looks very different
from what the patch expects. Seem it was already patched with some
other gcc3 stuff between 2.4.25 and 2.4.26.

Martin

=====
------------------------------------------------------
Martin Knoblauch
email: k n o b i AT knobisoft DOT de
www:   http://www.knobisoft.de
