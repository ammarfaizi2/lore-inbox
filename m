Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423034AbWJVG3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423034AbWJVG3W (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 02:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423037AbWJVG3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 02:29:22 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:29277 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1423034AbWJVG3V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 02:29:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=J4qBcXdyveTczF/Bh81/dcoQIpfHzgIrNkxm1MsXQQiJNWarpa690fVO6TGFkdQattflWGwwid4o1xtrC2uATWLWIQOON5/p19HpWOp+ETMQFAUG2gViBdNMrxwyAyVHq6dx/R0eILex1D58bmv5foEhgkGIZcy3MGXWCUr2PT4=
Message-ID: <37d33d830610212329o420e0ee4i75e6bddfcf2fb772@mail.gmail.com>
Date: Sun, 22 Oct 2006 11:59:20 +0530
From: "Sandeep Kumar" <sandeepksinha@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: PAE and PSE ??
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I have read in UTLK by bovet that the linux kernel does not uses the
PSE bit on an x86
machine. Then how come we have the hugetlbfs, which provides support
for 4MB pages ?



-- 
Regards,
Sandeep





Winners expect to win in advance. Life is a self-fulfilling prophecy.
