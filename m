Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261393AbVBWCe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbVBWCe7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 21:34:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261395AbVBWCe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 21:34:59 -0500
Received: from rproxy.gmail.com ([64.233.170.196]:61780 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261393AbVBWCe5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 21:34:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding;
        b=Obb74aT/CFGwovPRgy5tLrMSmOivFssoeotURDVtrQcBydB+tjeHy5vP35N/kkXPH8k7tquikmETEedCnoInUj+rd3nZmJwvuBn7vtgAmcw3NFp9fSu78x5GbFz34ZIsC6zl7chCJT5eQXJKP9KizQ8tCX0a3ENnGqPO4ZBVNEM=
Message-ID: <d3a6bba005022218342404b24@mail.gmail.com>
Date: Tue, 22 Feb 2005 18:34:54 -0800
From: Anil Kumar <anilsr@gmail.com>
Reply-To: Anil Kumar <anilsr@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: loading driver automatically & manually
Cc: anilsr@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to install RHEL 4, 2.6.9-5.EL.  I have adaptec 39320
controller, The install CD already has aic79xx driver in it.  The
driver does NOT load for some reason. If I take the same aic79xx
driver source, Create an img  and install RHEL4 using linux dd, it
works fine.

Can you please let me know, what files/lookup tables does the OS look
into for loading a driver for 2.6?

Also can you please point me to steps on to how to replace an existing
driver(I suspect the default driver in RHEL4 CD may be wrong)  in the
RHEL4 install CD with my own aic79xx built driver?

with regards,
   Anil
