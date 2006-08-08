Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030327AbWHHWYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030327AbWHHWYt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 18:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030328AbWHHWYs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 18:24:48 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:14441 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030283AbWHHWYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 18:24:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=BRQ92KtYsC4N+gYie7rtGpAEe7/xMPuw+4KXVkYgtc05s+AUbaVm4aerg5hTp129gQ1+n+Nqo3EttqxyziUtezQeU4f2xJjBn5SopGZ1ofvaxErR+nE5XsMzJbX7CJZHdLrRALTN8DrKlAPEPCwd9+5Vrlxgyuy25rBRNOfYOpg=
Message-ID: <4ae3c140608081524u4666fb7x741734908c35cfe6@mail.gmail.com>
Date: Tue, 8 Aug 2006 18:24:47 -0400
From: "Xin Zhao" <uszhaoxin@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: What's the NFS OOM problem?
Cc: linux-fsdevel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I often heard of the OOM probelm in NFS, but don't know what it is.
Now I am developing a NFS based system and found my system memory
(server side) is used too fast. I checked the code but didn't find
memory leaking. So I suspect I run into OOM issue.

Can someone help me and give me a brief description on OOM issue?

Many many thanks!
-x
