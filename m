Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965245AbVHJSLq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965245AbVHJSLq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 14:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965246AbVHJSLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 14:11:46 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:58038 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965245AbVHJSLp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 14:11:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding:from;
        b=QX9Da6EoI1CHI9Ez9QPgzmGrlmpB56HlC7Bk+lsqmL9tSKzudYJC8G27tXYsp72MGQ6Q09a6VaP5Qq5kau7n+LV43Zp7sK2TVi7paP7O0+yigmsCKLYKoNaOlV3r4LpC61d0JyEywWxoEcqwmark8gGUN12UMJ5iER1tRnUXHfI=
Message-ID: <42FA4355.7010004@gmail.com>
Date: Wed, 10 Aug 2005 20:11:33 +0200
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050808)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>,
       linux mailing-list <linux-kernel@vger.kernel.org>
Subject: NCQ support NVidia NForce4 (CK804) SATAII
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
From: Michael Thonke <iogl64nx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jeff,

I would like to ask what the plans/timeplan to implement NCQ support for 
NVidia NForce4(CK804) SATAII based chipsets? Fact is that is it possible 
to use NCQ with NForce4 SATAII on Windows system, I wonder why it isn't 
support by libata? Is there something in your git-tree? Or what are the 
reasons/problems behind that libata is missing NCQ support for (CK804) 
SATAII?


Greets and
Best regards

-- 
Michael Thonke
IT-Systemintegrator /
System- and Softwareanalyist



