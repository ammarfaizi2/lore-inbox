Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264128AbTLAXgM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 18:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264155AbTLAXgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 18:36:12 -0500
Received: from main.gmane.org ([80.91.224.249]:62439 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264128AbTLAXgK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 18:36:10 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [OT] Rootkit queston
Date: Tue, 02 Dec 2003 00:36:07 +0100
Message-ID: <yw1xisl0un4o.fsf@kth.se>
References: <1070313094.11356.6.camel@midux> <Pine.LNX.4.53.0312011649060.4785@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:YnYhbsPL9oj9VRSAbdJgQgml7Es=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <root@chaos.analogic.com> writes:

>> They seem to have PID 0, is this normal?
>
> Yes. These are kernel threads.

That doesn't necessarily rule out the possibility of them being evil.
If someone has taken control of the system, he could have loaded some
module that started a thread disguising itself under a common name.

-- 
Måns Rullgård
mru@kth.se

