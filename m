Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbVABLcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbVABLcW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 06:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbVABLcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 06:32:22 -0500
Received: from web52207.mail.yahoo.com ([206.190.39.89]:49514 "HELO
	web52207.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261158AbVABLcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 06:32:19 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=N1+UhrEWMEfSMQ6xWalowlyo4TQ80HeS+6bDv3qKcESOYJQE+Ep8CCJvlm+cBo+fszQqZcIyXObjHt/UvKPAt7CEhDBUGO0IloP/yyv1z/6Fj1L/5RbOxgvzzvQ9v73/CQ3uuqgULxoKgLH3BxD3c6Trj9eEN2sdoGW48MYGJlA=  ;
Message-ID: <20050102113219.78691.qmail@web52207.mail.yahoo.com>
Date: Sun, 2 Jan 2005 03:32:19 -0800 (PST)
From: linux lover <linux_lover2004@yahoo.com>
Subject: what is mean by linear socket buffers?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
 On Internet i found one document that states
following statement "Linux chooses to use linear
buffers and save space in advance because linear
buffers make many other things much faster."

I want to know what is linear buffers? are they
different than what we declare in normal C programming
syntax unsigned char *str.
regards,
linux_lover



		
__________________________________ 
Do you Yahoo!? 
The all-new My Yahoo! - What will yours do?
http://my.yahoo.com 
