Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132691AbRDQOl0>; Tue, 17 Apr 2001 10:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132692AbRDQOlR>; Tue, 17 Apr 2001 10:41:17 -0400
Received: from lange.hostnamen.sind-doof.de ([212.15.192.219]:46084 "HELO
	xena.sind-doof.de") by vger.kernel.org with SMTP id <S132686AbRDQOlA> convert rfc822-to-8bit;
	Tue, 17 Apr 2001 10:41:00 -0400
Date: Tue, 17 Apr 2001 16:39:05 +0200
From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
To: gis88530 <gis88530@cis.nctu.edu.tw>
Cc: linux-kernel@vger.kernel.org
Subject: Re: icmp and port
Message-ID: <20010417163905.K4385@kallisto.sind-doof.de>
Mail-Followup-To: gis88530 <gis88530@cis.nctu.edu.tw>,
	linux-kernel@vger.kernel.org
In-Reply-To: <004901c0c74a$c50880b0$ae58718c@cis.nctu.edu.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.2.5i
In-Reply-To: <004901c0c74a$c50880b0$ae58718c@cis.nctu.edu.tw>; from gis88530@cis.nctu.edu.tw on Tue, Apr 17, 2001 at 10:28:53PM +0800
X-Operating-System: Debian GNU/Linux (Linux 2.4.3-ac5-int1-nf20010413-dc1 i686)
X-Disclaimer: Are you really taking me serious?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 17, 2001 at 10:28:53PM +0800, gis88530 wrote:
> 
> Do icmp packets have port information?

ICMP packets quote part of the original packet that triggered the ICMP
message. From this quoted part, information can be extracted about the
connection the ICMP packet belongs to.

Andreas
-- 
I *____knew* I had some reason for not logging you off... If I could just
remember what it was.

