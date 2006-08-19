Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161042AbWHSGes@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161042AbWHSGes (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 02:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161048AbWHSGes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 02:34:48 -0400
Received: from wx-out-0506.google.com ([66.249.82.226]:9110 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161042AbWHSGes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 02:34:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=cY2+5XJasynWWNvso54feLFE1XkduE0Qd451Hp0gUgfDfh4475Y9TClL7DcU+oMMbuXdzsB5a6388p0M4W0JyPH6XiTg2uY66t+WSy8R3Ga0od+M4xu2HShrO5VTTex9UxF5qgWdTHwmU2l3n1jyEjCIfEcKFY0w/gtHhG5Ob/Y=
Message-ID: <5d7aca950608182334l41a4aa0fjd64798dfc5067ceb@mail.gmail.com>
Date: Sat, 19 Aug 2006 15:34:47 +0900
From: NAHieu <nahieu@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Get list of open TCP/UDP ports from inside kernel
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

 I am working on a project to do inspection for kernel integrity. I
want to get the list of open TCP/UDP ports from inside kernel (not
from userspace). Would anybody please tell me how could I do  that? Is
there any link list pointed to such stuffs?


Many thanks.
 H
