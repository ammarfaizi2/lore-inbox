Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750997AbVIUOhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbVIUOhV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 10:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbVIUOhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 10:37:21 -0400
Received: from xproxy.gmail.com ([66.249.82.205]:57785 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750994AbVIUOhV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 10:37:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=g54o+fkCe87Pzw6zRdB/5NsSNHUza4GMPUJF6h5tCkmBOCfnUEu4EshnWJ4lD1hI0o/PW5jkERPTIgOGks/sIc4NgPz/zLWPXS7MavLtYqH/i60YExl3dKjuNFjPQvtGhOnzctnpsyGJa6BB9JeU6CowOwROBN0gntNzhIcXiQY=
Message-ID: <4ae3c140509210737383422b3@mail.gmail.com>
Date: Wed, 21 Sep 2005 10:37:20 -0400
From: Xin Zhao <uszhaoxin@gmail.com>
Reply-To: Xin Zhao <uszhaoxin@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Is stack back trace possible if compiled with -fomit-frame-pointer?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also, I might want to know whether it is common case that linux apps
are compiled with  -fomit-frame-pointer swtich?

Thanks!
Xin
