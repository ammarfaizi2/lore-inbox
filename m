Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262121AbVBKDbT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262121AbVBKDbT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 22:31:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262133AbVBKDbT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 22:31:19 -0500
Received: from rproxy.gmail.com ([64.233.170.195]:13778 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262121AbVBKDbR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 22:31:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=nQr2e5KXKLvbhXY72yhBCS4cYmv1pLLfjfZo5djE1gb8IGSBALFaADshffbsEvqMGpX0juy+SZ4BGF9CipJUNNNXnEpBoO4FzkN8gk56juvlUZLaT/mMOSHrahWEF+biLWlDUBoN4j+r9YvERdQlILob2nwps8ISiV3tkQxoVhg=
Message-ID: <a3af00b80502101931282f1813@mail.gmail.com>
Date: Thu, 10 Feb 2005 19:31:17 -0800
From: Bill Brandel <bill.brandel@gmail.com>
Reply-To: Bill Brandel <bill.brandel@gmail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Kernel log filtering
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm running Linux 2.6.10 from Fedora Core 2  and I have enabled
rejected packet logging so
log-watch is able to alert me on possible attacks.   This however goes
in "dmesg" making it unusable to check for serious condition.  Is
there any way to only redirect such messages to the file
without having them in Dmesg ? 

Thanks.

-- 
Bill Brandel, http://www.generalcatalog.info - Start your Internet Search Here
