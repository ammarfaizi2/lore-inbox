Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315862AbSFESPs>; Wed, 5 Jun 2002 14:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315893AbSFESPr>; Wed, 5 Jun 2002 14:15:47 -0400
Received: from 24-25-196-177.san.rr.com ([24.25.196.177]:47625 "HELO
	acmay.homeip.net") by vger.kernel.org with SMTP id <S315862AbSFESPp>;
	Wed, 5 Jun 2002 14:15:45 -0400
Date: Wed, 5 Jun 2002 11:15:46 -0700
From: andrew may <acmay@acmay.homeip.net>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Ben Greear <greearb@candelatech.com>, linux-kernel@vger.kernel.org
Subject: Re: packets being dropped in IP stack but no error counts incrementing?
Message-ID: <20020605111546.A25385@ecam.san.rr.com>
In-Reply-To: <3CFD01F8.B69152E4@nortelnetworks.com> <3CFD9B9C.1050906@candelatech.com> <3CFE47D1.A4A3D0B4@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2002 at 01:18:09PM -0400, Chris Friesen wrote:
> Ben Greear wrote:
> > 
> > I am not sure the UDP drop counters are available.  If you do
> > find them, I'm interested in them too!
 

You are using netstat -s/cat /proc/net/snmp and ifconfig/cat /proc/net/dev
