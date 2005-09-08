Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbVIHGqb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbVIHGqb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 02:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbVIHGqb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 02:46:31 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:50795 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751091AbVIHGqb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 02:46:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=pw11nXPU92gqw97UTDyPuB0KRin9BkgRvMssNxXGrT948jKb0cNYLUavIkbyV+BSJvcxZLcO8xYR2i6C04Oaxpk60UHkhs5hNNGpvW8PvBZ2CCKRtYmthNfdBZswWizIr02GU7w+V7yoaO2OrTONPWbvdrFrrxqgbVQtSzA9hOM=
Message-ID: <4ae3c14050907234669ef3b6e@mail.gmail.com>
Date: Thu, 8 Sep 2005 02:46:24 -0400
From: Xin Zhao <uszhaoxin@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: How is SELinux integrated into kernel 2.6?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry if this question is dumb.

SELinux is included in 2.6. But I think it works by putting LSM hooks a lot
of place in Linux and then it can define its own policy enforcement codes.

However, I cannot find hooks in kernel 2.6.9 and 2.6.11. How can
SELinux work with kernel 2.6 to protect system without hooks?

Thanks in advance for your help!

Xin
