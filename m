Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932170AbWAJKuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932170AbWAJKuX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 05:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbWAJKuW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 05:50:22 -0500
Received: from uproxy.gmail.com ([66.249.92.192]:5410 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932156AbWAJKuS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 05:50:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=BrATn47Md9q+Od2B1GigMFtjcWZ82h5mZM2DlKK7nmSObuYtHjKBDjGretBIBy0H7UbkVv8hTFHPtBryrVA5We+Df+Ba0Uk9bMI/Pvw4hm4IFzeuClc1Vk7OcFJYAbGmxR6R4DD0659MeeQHf0jDdJDkASwtFa5tc9/xJSqLhic=
Date: Tue, 10 Jan 2006 11:50:08 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Yaroslav Rastrigin <yarick@it-territory.ru>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, vda@ilport.com.ua
Subject: Re: Why the DOS has many ntfs read and write driver,but the linux
 can't for a long time
Message-Id: <20060110115008.3c803330.diegocg@gmail.com>
In-Reply-To: <200601101220.03848.yarick@it-territory.ru>
References: <174467f50601082354y7ca871c7k@mail.gmail.com>
	<200601091207.14939.yarick@it-territory.ru>
	<20060109231313.2d455d5f.akpm@osdl.org>
	<200601101220.03848.yarick@it-territory.ru>
X-Mailer: Sylpheed version 2.1.6 (GTK+ 2.8.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Tue, 10 Jan 2006 12:20:03 +0300,
Yaroslav Rastrigin <yarick@it-territory.ru> escribió:


> Bug #1188 . See for yourself about quality of reported data, relevant maintainers and my prepareness to work with them to resolve.
> (P.S. Two fscking years.)


I see 44 comentaries there. It's not that people haven't tried to
help you (several of them don't get any money for helping to
fix stuff). In fact they've been following the bug for two years,
which proves how good bugzilla maintainers the intel acpi guys are.
You've indeed helped people to debug the problem, but there're some
bugs that just are hard to fix (and hardware manufacturers not
collaborating to make their hardware work in linux doesn't makes
it easier).
