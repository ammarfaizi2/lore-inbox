Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267352AbUJRVCV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267352AbUJRVCV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 17:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267409AbUJRVCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 17:02:20 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:57680 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267352AbUJRVCG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 17:02:06 -0400
DomainKey-Signature: a=rsa-sha1; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=Wf90oU+6NqXnwGexlgeFXJ9PvVJvhrbJ1OVAPcMCbXw1KuZ6KuhprJ0KeKtSN+EN1xyGEesDYw2gkmcMHR9rarcRQ5qP6B6NI8KHE344T/fvB4G+DEb9XUyJjFfgTzC3tnlYbqsrmi5No7ASuVvPLzPN7xsEPEb3jVWqZV1uDD0
Message-ID: <7aaed09104101814026a75f8ec@mail.gmail.com>
Date: Mon, 18 Oct 2004 23:02:02 +0200
From: =?ISO-8859-1?Q?Espen_Fjellv=E6r_Olsen?= <espenfjo@gmail.com>
Reply-To: =?ISO-8859-1?Q?Espen_Fjellv=E6r_Olsen?= <espenfjo@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.9-rc4-mm1 amd64 Computer crashes on "Freeing unused kernel memory: 200k"
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently got a new AMD64 3400+ computer, i'm installing gentoo from
the gentoo-amd64-livecd.
All goes well, until i try to boot my newly compiled kernel.
I't stops at "Freeing unused kernel memory: 200k", no oopses or other
information.
I compiled it with gcc-3.3.4.


Just ask and i'll try to give you more information about my system.

-- 
Mvh / Best regards
Espen Fjellvær Olsen
espenfjo@gmail.com
Norway
