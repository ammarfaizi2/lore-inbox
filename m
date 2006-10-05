Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751152AbWJEMPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbWJEMPb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 08:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751431AbWJEMPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 08:15:31 -0400
Received: from wx-out-0506.google.com ([66.249.82.230]:17414 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751152AbWJEMPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 08:15:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Sk0cq+MqLo3RU8t9ke4W3v8mKFph/caC1gY7uNxMKf0u3D6HjWCbGXIpCrhIqKsz6x55BGY/g6KuYwcLGDiGBK+HFwyvBg8S7285whAxJjpMhaJ0cbQRZ98mCaKu7WtJVtvo+Cv1M1VkcKdfUCEAZI97IKXQqVhg23tN29eLuGQ=
Message-ID: <dc0fd3dd0610050515h48f9de0fuc372396cfdb84aa5@mail.gmail.com>
Date: Thu, 5 Oct 2006 12:15:29 +0000
From: "Naveed Basha" <naveedbasha@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Device Driver
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am developing a device driver in Linux using C, wherein the processes
communicate via a shared memory.

Can you please tell me how should I design the memory. whether it
should be at the kernel level or at the user level. And if at the
kernel level, give me the functions and APIs to use.

Thanks and regards,
Naveed
