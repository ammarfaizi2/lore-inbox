Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946747AbWKAJ75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946747AbWKAJ75 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 04:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946749AbWKAJ75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 04:59:57 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:4637 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1946747AbWKAJ75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 04:59:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=d4Xq6oV/YLqBCn2GaVF7DbWW4vSa0W7QbkNeDoGFUOpfT3itDTmZIJjNed4Oy8zjPa842qsFfOWWwW2kHWwlzLoCq5R/Hht2X9Xu9UuOk7klm8AELO1LMcojZO0cof+MFJ2D+xMU38o3RJHlDN8y/T4JBncLdrJYEV0uTOb1cPo=
Message-ID: <3dd9a95e0611010159h7dc1d7b7o908b599d7b3200f9@mail.gmail.com>
Date: Wed, 1 Nov 2006 17:59:55 +0800
From: "Xiao Niu" <gniuxiao.mailinglist@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: How does the kernel interrupt a user process with code while (1) {}?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As title, thanks ;-)
