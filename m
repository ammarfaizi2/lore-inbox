Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272766AbTHEN24 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 09:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272788AbTHEN2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 09:28:55 -0400
Received: from mail.ideaone.net ([64.21.232.2]:9666 "EHLO arlene.ideaone.net")
	by vger.kernel.org with ESMTP id S272766AbTHEN22 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 09:28:28 -0400
Subject: Re: Will kernel compiled for PentiumII run on IBM 6x86MX?
From: Reid Hekman <hekman@ideaone.net>
To: linux-kernel@vger.kernel.org
In-Reply-To: <3F2FA47B.3040007@asfandyar.cjb.net>
References: <3F2FA47B.3040007@asfandyar.cjb.net>
Content-Type: text/plain
Message-Id: <1060090103.21278.4.camel@artemis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 05 Aug 2003 08:28:23 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-08-05 at 07:35, Asfand Yar Qazi wrote:
> Hi,
> 
> Read somewhere that the 6x86MX is PentiumII code compatible, but these 
> processors are listed as two separate options under the kernel config 
> (2.4.21)
> 
> Will a kernel/apps compiled for PII run on a 6x86MX?

You could try, but I wouldn't recommend it. IBM/Cyrix 6x86MX is more
like CONFIG_M586MMX. It's a souped up Pentium really (read not P6).

> 
> Thanks,
> 	Asfand Yar

Regards,
Reid
-- 
Reid Hekman <hekman@ideaone.net>

