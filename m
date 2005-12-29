Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932590AbVL2IGW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932590AbVL2IGW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 03:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932591AbVL2IGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 03:06:22 -0500
Received: from xproxy.gmail.com ([66.249.82.194]:2246 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932590AbVL2IGV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 03:06:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=bhgScezBzcRuQZXVsODQIIhm5b82Lc4q9y293FbIMlZ7O6Mx3+aLbPhzKgnuM/GR67mTtdFPMONgCqFN1Td5Zk1OY0FUt0XM2bNZaw8/kWSU26qbyFqKk/fDuMeVp5I511Qmwg5u0HNqAXf+wXrmG5fgYfSyXICOjF1JCaaZmmg=
Message-ID: <993d182d0512290006k54638f33h79bc17cb99db31e7@mail.gmail.com>
Date: Thu, 29 Dec 2005 13:36:20 +0530
From: Conio sandiago <coniodiago@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: statistics problem
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all
i have a embedded linux.
if i execute ifconfig eth0 then
i am able to see the IP address ,but i am not able to see the other
statistics like Tx errors Rx errors.
everything is shows as zeros.
does anyine has some idea about it
