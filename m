Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292330AbSCDNC6>; Mon, 4 Mar 2002 08:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292338AbSCDNCs>; Mon, 4 Mar 2002 08:02:48 -0500
Received: from smtp014.mail.yahoo.com ([216.136.173.58]:29455 "HELO
	smtp014.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S292330AbSCDNCh>; Mon, 4 Mar 2002 08:02:37 -0500
Content-Type: text/plain; charset=US-ASCII
From: Yaroslav Buga <slava_buga@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: Group membership problem
Date: Mon, 4 Mar 2002 15:02:26 +0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020304130241Z292330-889+117131@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have Slackware 7.1 with 2.4.16 kernel. And I have a user who is a member of 
a number of groups. Linux can't grant access to the user if the group's 
number he is member of is more than 32. For example if he is member of 32 
groups - everything is O.K. , but when I make him a member of the 33-rd group 
he will not be granted access to resource which is owned by that group. 
Is there any limit in Linux for the number of groups to be member of?
And how can I solve that problem?

Thanks guys in advance.
Yaroslav Buga.

_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

