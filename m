Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbVHWJHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbVHWJHP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 05:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbVHWJHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 05:07:15 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:2095 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932099AbVHWJHO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 05:07:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=i+NNVGs+RVoQPsXaFq7BOWea4xSBak7n/N2Gykh6pdi3tuBiFiZhQqxlQK5lmRiLkhw5jH1RId2JBjNCkCiTsIXWHdosBXfW0LoHwVF3oQDiTSndDVbKqR+60IOouQwJDVjMtjpQg2VMHc2Em4ZZCp7rWEzYEjRlrBBmn+rPN+A=
Message-ID: <7cd5d4b4050823020772cc5c9e@mail.gmail.com>
Date: Tue, 23 Aug 2005 17:07:12 +0800
From: jeff shia <tshxiayu@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: what does scsi sense means?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

in the file of aic7xxxx.c ,what is the function of the structure of
scsi_sense?here what is the meaning of  sense?just like probe?

any help will be appreciated!
Thank you!

Jeff
