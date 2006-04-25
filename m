Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751206AbWDYP1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206AbWDYP1K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 11:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbWDYP1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 11:27:10 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:32411 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751206AbWDYP1J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 11:27:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=HHOwy2MrxmyvxV6n9X/xlictIEFh2u/WUhBLt3ZZZZy21sSEHogjKStnP/IlU+P+uLrb2/+wkCaYcMhn+3xykHlkZQ2hGGNVQssxci1HdLXLjUvtWhDExUhtIfrqRsKXBU7ktFoNayBwPE4nWfKtG16zqlcZU7NIqc7fji2sGn8=
Message-ID: <4ae3c140604250827y67675fednba67ffdb67405b87@mail.gmail.com>
Date: Tue, 25 Apr 2006 11:27:08 -0400
From: "Xin Zhao" <uszhaoxin@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Is there an easy way to collect how much memory is used for page cache?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Specifically, how much memory is used to cache data for file systems? 
Any way to measure it?

Thanks!

-x
