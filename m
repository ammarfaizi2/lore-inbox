Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266059AbRGRBIM>; Tue, 17 Jul 2001 21:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266523AbRGRBIC>; Tue, 17 Jul 2001 21:08:02 -0400
Received: from suntan.tandem.com ([192.216.221.8]:55513 "EHLO
	suntan.tandem.com") by vger.kernel.org with ESMTP
	id <S266059AbRGRBHt>; Tue, 17 Jul 2001 21:07:49 -0400
Message-ID: <3B54DEF5.B85F57E4@compaq.com>
Date: Tue, 17 Jul 2001 17:57:25 -0700
From: "Brian J. Watson" <Brian.J.Watson@compaq.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>,
        schoebel@eicheinformatik.uni-stuttgart.de
Subject: Common hash table implementation
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of days ago, I was thinking about a common hash table
implementation, ala include/linux/list.h. Then I came across
include/linux/ghash.h, and thought that someone's already done it.
After that I noticed the copyright line said 1997, and a quick check
in cscope showed that nobody's including it.

Does anyone know if this file is worth studying and working with? I
have to wonder if nobody's using it after four years.

Does anyone see a problem with a common hash table implementation?
I've implemented a few hash tables from scratch for our clustering
work, and it's starting to get a little old. Something easy to use
like list.h would be a lot nicer.

-- 
Brian Watson             | "The common people of England... so 
Linux Kernel Developer   |  jealous of their liberty, but like the 
Open SSI Clustering Lab  |  common people of most other countries 
Compaq Computer Corp     |  never rightly considering wherein it 
Los Angeles, CA          |  consists..."
                         |      -Adam Smith, Wealth of Nations, 1776

mailto:Brian.J.Watson@compaq.com
http://opensource.compaq.com/
