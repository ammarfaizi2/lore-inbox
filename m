Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbVKTMTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbVKTMTO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 07:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbVKTMTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 07:19:14 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:6761 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751221AbVKTMTO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 07:19:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=XgrRQ1d5m8LqDWQFoutim7khzoSJ0VF1VdSkMlsLk2foQ2l4JVOCvFPnUFbqzlWeVRQ1SPpTxqYNqILsVxAzTKxEnSrai5/ys7azIh8mcpzBw2B3CaIn0sTxrPGVWwXQB5SgA55lu5gyZu0aptffngDkjWnq22OYM5u8192QiFA=
Message-ID: <438069BD.6000401@gmail.com>
Date: Sun, 20 Nov 2005 13:19:09 +0100
From: Xose Vazquez Perez <xose.vazquez@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
Subject: [RFC] Documentation dir is a mess
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

_today_ Documentation/* is a mess of files. It would be good
to have the _same_ tree as the code has:

Documentation/
Documentation/arch/
Documentation/arch/i386/
[...]
Documentation/drivers/
Documentation/drivers/net/
Documentation/drivers/scsi/
[...]
Documentation/net
[...]


-thanks-

-- 
Romanes eunt domus
